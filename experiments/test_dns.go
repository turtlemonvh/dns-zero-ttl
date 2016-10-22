package main

import "net/http"

func main() {
    for i:=0; i<100; i++ {
        _, _ = http.Get("http://web.service.consul:8080")
    }
}
