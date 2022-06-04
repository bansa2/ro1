resource "aws_eks_cluster" "aws_eks" {
  name     = "eks_cluster_ayush"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [aws_subnet.ps_1.id,aws_subnet.ps_2.id]
  }
  tags = {
    "Name" = "EKS_ayush"
  }
}

resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = "node_ayush"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = [aws_subnet.ps_1.id,aws_subnet.ps_2.id]
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
  depends_on = [
    aws_iam_role_policy_attachment.AMZONEKSWORKERNODEPOLIY,
    aws_iam_role_policy_attachment.AmazoneEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistery,
  ]
}
