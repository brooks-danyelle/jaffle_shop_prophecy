with DAG():
    top10__top_10_customers_by_spend = Task(
        task_id = "top10__top_10_customers_by_spend", 
        component = "Model", 
        modelName = "top10__top_10_customers_by_spend"
    )
