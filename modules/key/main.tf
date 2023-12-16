#Create key pair
resource "aws_key_pair" "julkey" {
    key_name = "julkey"
    public_key = file("../modules/key/julkey.pub")
}