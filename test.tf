variable "test" {
  type = list(map(list(string)))
  default = [
    {
      "dev1" = [
        "ssh -o 'StrictHostKeyChecking=no' ubuntu@ваш ip",
        "10.0.1.7",
      ]
    },
    {
      "dev2" = [
        "ssh -o 'StrictHostKeyChecking=no' ubuntu@ваш ip",
        "10.0.2.29",
      ]
    },
    {
      "prod1" = [
        "ssh -o 'StrictHostKeyChecking=no' ubuntu@ваш ip",
        "10.0.1.30",
      ]
    },
  ]
}
