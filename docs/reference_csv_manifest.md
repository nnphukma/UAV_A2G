# Dữ liệu tham chiếu tính độc lập (chưa phải kết quả chạy trực tiếp trong MATLAB)

Đã tính lại bằng Python (math/csv stdlib) từ **cùng công thức, bộ tham số và miền quét** của MATLAB, chỉ nhằm kiểm thử và cung cấp dữ liệu chuẩn bị cho TV3.

Để hoàn tất bàn giao chính thức, chạy `run_tests` và `main` trên máy MATLAB R2024b. Sau đó gửi lại chính các CSV do MATLAB vừa ghi đè vào `results/csv/`.

Kích thước bộ dữ liệu: distance=201, altitude=201, environment=402, tổng cộng 804 hàng.

## Mốc số học tại h=100 m, hg=1.5 m, r=500 m, f=2.4 GHz

- urban: d=509.609900 m, θ=11.144561°, FSPL=94.196765 dB, P(LoS)=0.117401, PL_avg=111.966144 dB.

- suburban: d=509.609900 m, θ=11.144561°, FSPL=94.196765 dB, P(LoS)=0.751871, PL_avg=99.482661 dB.

Không có số liệu đo thực địa; không kết luận phạm vi phủ sóng tối đa.
