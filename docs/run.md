## Các section của dự án DDD - vetautet.com

Nếu các bạn  người mới vào hãy cố gắng học chậm từng bước.
Tốt nhất là đầu tư vào bản thân mình, là cách đầu tư không bao giờ Lỗ...

01 - [SpringBoot 3: CÁCH xây dựng dự án triển khai về DDD bán VÉ TÀU, MUSIC với kiến trúc đồng thời CAO!](https://youtu.be/WFlIoNHD_Yo)

02 - [Chúng tôi xây dựng Structure DDD Project như thế nào đạt chuẩn?](https://youtu.be/hux9dtGQL7w)

03 - [Không tranh cãi, chúng tôi thống nhất hoàn thành kiến trúc DDD này](https://youtu.be/IcDiMkb7_TA)

04 - [Khi publish API chúng tôi gặp lượng request rất nhiều, áp dụng Circuit Breaker vs RateLimiter](https://youtu.be/tK7NDEr_vtE)

05 - [Sếp bảo tăng tốc từ 1000 lên 10.000 req/s, chúng tôi quyết định thêm Distributed Cached](https://youtu.be/GqCohsho54s)

06 - [Sếp - Tại sao chúng ta không sử dụng LUA Redis mà chọn Redisson cho chức năng Lock](https://youtu.be/zQWWGnhyZ0s)

07 - [Sếp ơi, làm ơn đừng gọi em nửa đêm nữa, chúng tôi đã thiết lập giám sát hệ thống Prometheus vs Grafana](https://youtu.be/MGQrPOrtKhE)

08 - [Chúng tôi đã thiết lập giám sát Database thông qua Prometheus vs Grafana, giờ ngủ ngon rồi](https://youtu.be/jqspVKUye9M)

09 - [Thiết lập giám sát Redis thông qua Prometheus vs Grafana và chuẩn bị thiết lập 20.000 req/s](https://youtu.be/5IuSc2NAM60)

10 - [Chuẩn bị có việc tăng tốc từ 10.000 lên 20.000 req/s không tăng chi phí](https://youtu.be/gv_XHpOigbk)

11 - [Sếp cảm ơn anh em vì hoàn thành việc tăng tốc từ 10.000 lên 20.000 req/s nhưng team đối mắt với vấn đề khác](https://youtu.be/4n57Tmam4lE)

12 - ...

## How to run

Open environment -> Run
> docker-compose -f environment/docker-compose-dev.yml up

Câu lệnh trên sẽ tự động tạo db với các thông số sau:
```bash
MYSQL_ROOT_PASSWORD: root1234
MYSQL_DATABASE: ticket
MYSQL_PASSWORD: root1234
```
Chú ý: Khi run thành công thi sẽ tự tạo một folder `data/db_data` trong `environment`, tương tự như các folder khác...

## How to test
View video: Tuyến phòng thủ thứ 4

## Upgrade video 4 -> 9

Chú ý: Nếu máy của mình không đủ mạnh để chạy file docker full thì hãy chạy phiên bản `docker-lite` nằm ở thư mục `environment`. Và chỉnh
sửa lại file `prometheus.yml` cho hợp lý thông qua các video đã học.

## Có vấn đề khi build 4 -> 9

Vui lòng truy cập vào link discord: https://youtu.be/AsLW8Xt0UHs và để lại câu hỏi trong nhóm...

## Upgrade video 9 - 16

Xem video build project pom/xml: https://youtu.be/S0jeMyqSrVE
Xem video buil project kafka broker: https://youtu.be/S0jeMyqSrVE

