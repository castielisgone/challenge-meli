from challenge_meli.custom_sessions import spark_session
from challenge_meli.utils.constants import consts
from challenge_meli.utils.functions import merge_dataframes
from datetime import date
import requests
class Items():
    """Holds the logic to extract data from the "items_api" endpoint of the API,
    from MELI.
    Args:
        url (str): Base API url.
        start_date (date): Start period to query results (closed interval).
             Default is None. This field can be used in future to incremental data.
        end_date (date): End period to query results (open interval).
            Defaults is  None.
        limit (int, optional): Number of limit if the request. Defaults to 150.
        selected_columns: (list): List of selected columns to analysis.
        product_list: (list): List of Items to analysis.
    """

    def __init__(
        self,
        url: str,
        product_list: list = consts.PRODUCT_LIST,
        selected_columns: list = consts.SELECTED_COLUMNS,
        user: str = None,
        token: str = None,
        start_date: date = None,
        end_date: date = None, 
        limit: int = 150,
        items : dict = None,
    ):
        self.url = url
        self.selected_columns = selected_columns
        self.product_list = product_list
 

    def extract_raw(self):
        """Yields the API response for this endpoint.
        In this case, yields a dictionary containing a list of results.
        Yields:
            dict: Json containing the API results
        """
        dict_of_items = {}
        
        #Itera primeiramente na lista de Produtos, consultando a API de sites
        #armazenando o id do Item, para a consulta da API de Items/
        for product in self.product_list:
            self.url = f"https://api.mercadolibre.com/sites/MLA/search?q={product}&limit={self.limit}#json"
            r = requests.get(url = self.url)
            data = r.json()
            value = [result['id'] for result in data['results']]
            key =  data['query']
            dict_of_items.update({key: value})
        
        #Itera sobre a api de Items, retornando um JsonData contendo os dados
        for key, value in dict_of_items.items():
            for item in value:
                URL = f"https://api.mercadolibre.com/items/{item}"
                request = requests.get(url = URL)
                self.items = request.json()
            
        return self.items
    
    def create_clean_table(self):
        """Create a table enriched, based on Json data.
        Yields:
            Dataframe: Spark Dataframe containing results.
        """
        #Inicializa a sessão Spark, realizando uma limpeza nos Items 
        spark = spark_session()
        dataframes = []
        #Cria a tabela enriquecida baseada nas colunas de interesse, utilizando
        #dict comprehesion.
        enrich_table = {key: value for key, value in self.items.items() if key in self.selected_columns}
        dataframe = spark.createDataFrame([enrich_table])
        dataframes.append(dataframe)
        dataframe_enrich = merge_dataframes.merge_dataframes(dataframes)

        return dataframe_enrich
