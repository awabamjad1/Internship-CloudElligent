[
   {
      "portMappings":[
         {
            "hostPort":5000,
            "protocol":"tcp",
            "containerPort":5000
         }
      ],
      "cpu":10,
      "memory":300,
      "image":"awabamjad/sprint10:latest",
      "name":"backend",
      "logConfiguration":{
         "logDriver":"awslogs",
         "options":{
            "awslogs-region":"us-east-1",
            "awslogs-stream-prefix": "ecs",
            "awslogs-group":"${aws_cloudwatch_log_group}"
         }
      }
   }
]