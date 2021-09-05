import sys
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.transforms import *
from awsglue import DynamicFrame
from awsglue.utils import getResolvedOptions, GlueArgumentError
from pyspark import SparkContext

sparkContext = SparkContext.getOrCreate()
glueContext = GlueContext(sparkContext)


ddf_1 = glueContext.create_dynamic_frame.from_catalog(database = "use_case_name", table_name = "inventory_csv")
ddf_1.printSchema()
print(ddf_1.count())


ddf_2 = glueContext.create_dynamic_frame.from_catalog(database = "use_case_name", table_name = "sales_csv")
ddf_2.printSchema()
print(ddf_2.count())


ddf_3 = Join.apply(frame1 = ddf_1, frame2 = ddf_2, keys1 = ["product"], keys2 = ["item"])
ddf_3.printSchema()
print(ddf_3.count())

def priceCalc(rec):
    rec["SubTotal"] = rec["units"]*rec["unit price"]
    return rec

ddf_4 =  Map.apply(frame = ddf_3, f = priceCalc)
ddf_4.printSchema()
print(ddf_4.count())
    
glueContext.write_dynamic_frame.from_options(
    frame = ddf_4,
    connection_type = 's3',
    connection_options = {'path': 's3://prod-data-zpgbv/Totals.csv'},
    format = 'csv')
