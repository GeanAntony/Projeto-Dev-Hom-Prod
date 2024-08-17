from diagrams import Diagram, Cluster, Edge
from diagrams.aws.compute import Lambda
from diagrams.aws.database import RDS, Dynamodb
from diagrams.aws.network import APIGateway, CloudFront
from diagrams.aws.storage import S3
from diagrams.aws.security import Cognito
from diagrams.aws.integration import SQS
from diagrams.aws.management import Cloudwatch

with Diagram("AWS Sales System Architecture", show=True):
    with Cluster("Frontend"):
        frontend = S3("Static Website S3")
        cdn = CloudFront("CDN")

    with Cluster("Authentication"):
        auth = Cognito("User Authentication")

    with Cluster("Backend"):
        with Cluster("API"):
            api = APIGateway("API Gateway")
            lambda_func = Lambda("Business Logic")

        with Cluster("Database"):
            db_rds = RDS("Relational Database")
            db_nosql = Dynamodb("NoSQL Database")

        with Cluster("Messaging"):
            queue = SQS("Message Queue")

    with Cluster("Monitoring"):
        logging = Cloudwatch("Logs & Metrics")

    # Connections
    cdn >> frontend >> api >> lambda_func
    auth >> api
    lambda_func >> db_rds
    lambda_func >> db_nosql
    lambda_func >> queue
    lambda_func >> logging