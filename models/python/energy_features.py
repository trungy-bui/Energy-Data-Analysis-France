from snowflake.snowpark.functions import (
    col, year, month, quarter,
    mean, stddev
)
from snowflake.snowpark.window import Window

def model(dbt, session):
    dbt.config(materialized="table")

    df = dbt.ref("int_energy")

    w = Window.partition_by()  # global window

    df = (
        df
        .with_column("year", year(col("DATE")))
        .with_column("month", month(col("DATE")))
        .with_column("quarter", quarter(col("DATE")))
        .with_column(
            "generation_twh_scaled",
            (col("GENERATION_TWH") - mean("GENERATION_TWH").over(w))
            / stddev("GENERATION_TWH").over(w)
        )
        .with_column(
            "consumption_twh_scaled",
            (col("CONSUMPTION_TWH") - mean("CONSUMPTION_TWH").over(w))
            / stddev("CONSUMPTION_TWH").over(w)
        )
        .with_column(
            "capacity_gw_scaled",
            (col("CAPACITY_GW") - mean("CAPACITY_GW").over(w))
            / stddev("CAPACITY_GW").over(w)
        )
        .with_column(
            "EMISSION_MT_SCALED",
            (col("EMISSION_MT") - mean("EMISSION_MT").over(w))
            / stddev("EMISSION_MT").over(w)
        )
    )

    df = df.select(
        "year",
        "month",
        "quarter",
        "generation_twh_scaled",
        "consumption_twh_scaled",
        "emission_mt_scaled",
        "capacity_gw_scaled"
    )

    return df