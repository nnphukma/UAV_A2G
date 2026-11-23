# HỢP ĐỒNG CSV – A2G / Thành viên 2 → Thành viên 3

**Đóng băng tên và thứ tự cột:**

```csv
scenario,environment,f_Hz,h_m,hg_m,r_m,d_m,theta_deg,fspl_dB,p_los,pl_avg_dB
```

| Cột | Đơn vị | Ý nghĩa |
|---|---|---|
| scenario | chuỗi | `distance` / `altitude` / `environment` |
| environment | chuỗi | `urban` / `suburban` |
| f_Hz | Hz | Tần số sóng mang, ở đây 2.4e9 |
| h_m | m | Độ cao UAV |
| hg_m | m | Độ cao anten trạm mặt đất |
| r_m | m | Khoảng cách ngang |
| d_m | m | Khoảng cách xiên |
| theta_deg | độ | Góc ngẩng |
| fspl_dB | dB | Suy hao không gian tự do |
| p_los | 0–1 | Xác suất LoS (không phải %) |
| pl_avg_dB | dB | Suy hao trung bình A2G theo mô hình |

## Ba kịch bản

- `distance.csv`: `scenario=distance`, `environment=urban`, 201 hàng, r từ 100 đến 3000 m, h=100 m.
- `altitude.csv`: `scenario=altitude`, `environment=urban`, 201 hàng, h từ 20 đến 300 m, r=500 m.
- `environment.csv`: `scenario=environment`, 402 hàng, urban + suburban, mỗi loại 201 hàng; cùng r từ 100 đến 3000 m, h=100 m.

## Tối thiểu 4 đồ thị TV3 nên vẽ

1. `pathloss_vs_distance.png`: trục r_m; so sánh `fspl_dB` và `pl_avg_dB` từ `distance.csv`.
2. `los_vs_altitude.png`: trục h_m, giá trị `p_los` từ `altitude.csv`.
3. `pathloss_vs_altitude.png`: trục h_m, `pl_avg_dB` từ `altitude.csv`.
4. `environment_comparison.png`: trục r_m, `pl_avg_dB` so sánh `urban`, `suburban` từ `environment.csv`.

## Ghi chú khoa học
- Không sử dụng `pl_avg_dB` như công suất phát/thu hoặc SNR.
- `p_los` là xác suất, không phải kết quả đếm vật cản thực tế.
- Trục tần số 2.4 GHz là giả định, không khẳng định được kiểm chứng thực nghiệm.
- Các CSV có trong gói bàn giao phụ là **bản tham chiếu tái tính độc lập ngoài MATLAB**; sau khi TV2 chạy `main` trên máy MATLAB thì nên thay bằng CSV do MATLAB trực tiếp sinh ra.
