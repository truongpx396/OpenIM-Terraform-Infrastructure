resource "aws_launch_template" "node-group-launch-template" {
      name_prefix = "eks-node-group"
      # image_id    = var.template-image-id
    
      block_device_mappings {
        device_name = "/dev/xvda"
    
      ebs {
          volume_size = 20
        }
      }
    
      ebs_optimized = true
    
      user_data = "${data.template_cloudinit_config.config.rendered}"
      # user_data = filebase64("${path.module}/example.sh")
    }

    data "template_cloudinit_config" "config" {
      gzip          = false
      base64_encode = true

      part {
        content = "${data.template_file.set-max-pods.rendered}"
      }
    }
    
     # /etc/eks/bootstrap.sh ${aws_eks_cluster.eks_cluster.name} --use-max-pods false --kubelet-extra-args '--max-pods=110'
    data "template_file" "set-max-pods" {
      template = <<-EOT
         #!/bin/bash
          set -ex
          cat <<-EOF > /etc/profile.d/bootstrap.sh
          export USE_MAX_PODS=false
          export KUBELET_EXTRA_ARGS="--max-pods=110"
          EOF
          # Source extra environment variables in bootstrap script
          sed -i '/^set -o errexit/a\\nsource /etc/profile.d/bootstrap.sh' /etc/eks/bootstrap.sh
      EOT
    }

         