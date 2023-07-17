from functools import reduce

def merge_dataframes(dataframes: list):
    """
    Merges a list of DataFrames into a single DataFrame.

    Args:
        dataframes (list): A list of DataFrames to be merged.

    Returns:
        DataFrame: The merged DataFrame containing the combined data from all input DataFrames.
    """
    merged_df = reduce(lambda dataframe, df: dataframe.unionAll(df), dataframes)

    return merged_df