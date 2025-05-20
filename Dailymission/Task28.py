import torch

print("PyTorch 버전:", torch.__version__)
print("CUDA 버전:", torch.version.cuda)
print("GPU 사용 가능 여부:", torch.cuda.is_available())
print("GPU 이름:", torch.cuda.get_device_name(0) if torch.cuda.is_available() else "None")
print("GPU 수:", torch.cuda.device_count() if torch.cuda.is_available() else 0)
