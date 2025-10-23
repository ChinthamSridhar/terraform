variable "vnetname"{
    type = string
    default = "vnet-practice-dev"
}

variable "resource_group_name"{
    type = string
    default = "rg-practice-dev"
}

variable "location"{
    type = string
    default = "East US"
}

variable "kvsubnetname"{
    type = string
    default = "kvsubnet-practice-dev"
}


variable "akssubnetname"{
    type = string
    default = "akssubnet-practice-dev"
}

variable "sasubnetname"{
    type = string
    default = "sasubnet-practice-dev"
}

variable "acrsubnetname"{
    type = string
    default = "acrsubnet-practice-dev"
}