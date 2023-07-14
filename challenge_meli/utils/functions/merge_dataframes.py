from functools import reduce

def merge_dataframes(dataframes: list):
    merged_df = reduce(lambda dataframe, df: dataframe.unionAll(df), dataframes)

    return merged_df