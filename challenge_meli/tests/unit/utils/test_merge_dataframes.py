from challenge_meli.utils.functions import merge_dataframes

class TestMergeDataFrames:
    def test_merge_dataframes(self):
            # Criação dos Dataframes
            df1 = self.spark.createDataFrame([(1, 'Alice'), (2, 'Bob')], ['id', 'name'])
            df2 = self.spark.createDataFrame([(3, 'Charlie'), (4, 'David')], ['id', 'name'])
            df3 = self.spark.createDataFrame([(5, 'Eve'), (6, 'Frank')], ['id', 'name'])

            # Chama a função para testar os dataframes
            merged_df = merge_dataframes.merge_dataframes([df1, df2, df3])

            # Verifica o resultado esperado da função
            expected_count = df1.count() + df2.count() + df3.count()
            actual_count = merged_df.count()
            assert expected_count == actual_count