output "Storage_Account_Name" {
  value = azurerm_storage_account.terraformtest1212.name
}

output "A_Secrect_From_KeyVault_Shhhh" {
  value = data.azurerm_key_vault_secret.SamplePassword.value
}
