variable "home_cdir_block" {
    type = list(string)
}

variable "name" {
    type = string
}

variable "game_mode_type" {
    type = string
    default = "PvE"
}

variable "password" {
    type = string
    sensitive = true
}
