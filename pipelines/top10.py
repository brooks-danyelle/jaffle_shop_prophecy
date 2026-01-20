with DAG():
    top10__top_10_customers = Task(
        task_id = "top10__top_10_customers", 
        component = "Model", 
        modelName = "top10__top_10_customers"
    )
