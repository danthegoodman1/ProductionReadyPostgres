bash -c "$(curl -L https://setup.vector.dev)"
sudo apt install vector -y

sudo systemctl enable vector
sudo systemctl start vector
