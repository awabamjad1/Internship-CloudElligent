resource "aws_eks_cluster" "eks_cluster" {
  name     = "k8-awab"
  role_arn = aws_iam_role.eks_service_role.arn

  vpc_config {
    subnet_ids = module.vpc.public_subnets
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }
}
resource "aws_launch_template" "eks_node_launch_template" {
  name_prefix   = "eks-node-launch-template"
  image_id      =  data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_group_names = [aws_security_group.eks_cluster_sg.id]

  //vpc_security_group_ids = [aws_security_group.eks_cluster_sg.id]
  # ...
}
resource "aws_eks_node_group" "eks_nodes" {

  depends_on = [aws_eks_cluster.eks_cluster]

  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "k8-awab"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = module.vpc.public_subnets

  instance_types = ["t2.micro"]
  

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 1
  }
  tags = {
    Name = "k8-awab"
    Owner = "Awab"
  }

}
