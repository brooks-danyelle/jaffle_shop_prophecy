with DAG():
    orders = Task(
        task_id = "orders", 
        component = "Dataset", 
        writeOptions = {"writeMode" : "overwrite"}, 
        table = {"name" : "orders", "sourceType" : "Table", "sourceName" : "danyelle.demo", "alias" : ""}
    )
    customers = Task(
        task_id = "customers", 
        component = "Dataset", 
        writeOptions = {"writeMode" : "overwrite"}, 
        table = {"name" : "customers", "sourceType" : "Table", "sourceName" : "danyelle.demo", "alias" : ""}
    )
