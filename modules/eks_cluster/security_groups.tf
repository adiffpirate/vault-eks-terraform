resource "aws_security_group" "ssh_eks_cluster" {
  name        = "${var.eks_cluster_name}-sg-ssh"
  description = "Allows SSH connections to all machines within the EKS cluster"

  vpc_id = var.network_vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [var.network_vpc_cidr]
  }

  tags = {
    Name    = "${var.eks_cluster_name}-sg-ssh"
    project = var.project
  }
}
