package main

import (
  "fmt"
  "log"
  "net/http"
  "time"
  "io"
)

func appHandler(w http.ResponseWriter, r *http.Request) {

  fmt.Println(time.Now(), "Hello from my new fresh server UPDATED")
  io.WriteString(w, `{"Hello from my new fresh server"}`)
}

// e.g. http.HandleFunc("/health-check", HealthCheckHandler)
func HealthCheckHandler(w http.ResponseWriter, r *http.Request) {
  // A very simple health check.
  w.WriteHeader(http.StatusOK)
  w.Header().Set("Content-Type", "application/json")

  // In the future we could report back on the status of our DB, or our cache 
  // (e.g. Redis) by performing a simple PING, and include them in the response.
  io.WriteString(w, `{"alive": true}`)
}

func main() {
  http.HandleFunc("/", appHandler)
  http.HandleFunc("/health-check", HealthCheckHandler)
  log.Println("Started, serving on port 8080")
  err := http.ListenAndServe(":8080", nil)

  if err != nil {
    log.Fatal(err.Error())
  }
} 
