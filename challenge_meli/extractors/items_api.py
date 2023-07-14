from challenge_meli.custom_sessions import spark_session
from challenge_meli.utils.constants import consts
from challenge_meli.utils.functions import merge_dataframes
from datetime import date
import requests


class Items():
    """.
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
 

    def extract_raw(self):
        """Yields the API response for this endpoint.
        In this case, yields a dictionary containing a list of results, where each
        result is a list with 100 results.
        Yields:
            dict: Json containing the API results
        """
        dict_of_items = {}

        for product in self.product_list:
            self.url = f"https://api.mercadolibre.com/sites/MLA/search?q={product}&limit={self.limit}#json"
            r = requests.get(url = self.url)
            data = r.json()
            value = [result['id'] for result in data['results']]
            key =  data['query']
            dict_of_items.update({key: value})
 
        for key, value in dict_of_items.items():
            for item in value:
                URL = f"https://api.mercadolibre.com/items/{item}"
                request = requests.get(url = URL)
                self.items = request.json()
            
        return self.items
    
    def create_clean_table(self):
        spark = spark_session(
    app_name="meli_challenge_api",
    configs=[("spark.jars", "assets/jars/graphframes-0.8.1-spark3.0-s_2.12.jar")],
    py_files=["assets/jars/graphframes-0.8.1-spark3.0-s_2.12.jar"],
    log_level="WARN",
) 
        dataframes = []
        clean_table = {key: value for key, value in self.items.items() if key in self}
        dataframe = spark.createDataFrame([clean_table])
        dataframes.append(dataframe)
        dataframe_clean = merge_dataframes.merge_dataframes(dataframes)

        return dataframe_clean
