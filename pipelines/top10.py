with DAG():
    customers = Task(
        task_id = "customers", 
        component = "Dataset", 
        writeOptions = {"writeMode" : "overwrite"}, 
        table = {"name" : "customers", "sourceType" : "Table", "sourceName" : "danyelle.demo", "alias" : ""}
    )
    orders = Task(
        task_id = "orders", 
        component = "Dataset", 
        writeOptions = {"writeMode" : "overwrite"}, 
        table = {"name" : "orders", "sourceType" : "Table", "sourceName" : "danyelle.demo", "alias" : ""}
    )
