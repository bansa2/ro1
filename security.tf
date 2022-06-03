resource "aws_security_group" "eks-cluster-grp" {
  name        = "eks_cluster_grp"
  description = "Cluster security"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks_cluster_grp"
  }
}

resource "aws_security_group_rule" "eks-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 30163
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-cluster-grp.id
  source_security_group_id = aws_security_group.eks-cluster-node-sg.id
  to_port                  = 30163
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-cluster-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-cluster-grp.id
  to_port           = 443
  type              = "ingress"
}


# Node group security group
resource "aws_security_group" "eks-cluster-node-sg" {
  name        = "eks-cluster-node-sg"
  description = "Security group for all nodes in the cluster"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster-node-sg"
  }
}

resource "aws_security_group_rule" "eks-cluster-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks-cluster-node-sg.id
  source_security_group_id = aws_security_group.eks-cluster-node-sg.id
  to_port                  = 65535
  type                     = "ingress"
}