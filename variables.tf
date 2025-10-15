variable "client_id"{
    type = string
}

variable "tenant_id"{
    type = string
}

variable "client_secret"{
    type = string
}

variable "subscription_id"{
    type = string
}

variable "resource_group_name"{
    type = string
    default = "rg-practice-dev"
}

variable "location"{
    type = string
    default = "East US"
}

variable "saname"{
    type = string
    default = "sapractice1dev"
}

variable "name"{
    type = string
    default = "sapractice1dev"
}
