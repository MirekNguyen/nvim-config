local formattingOff = function()
  return function(client)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
  end
end
local omnisharp_fix = function() return function(client) client.server_capabilities.semanticTokensProvider = { full = vim.empty_dict(), legend = { tokenModifiers = { "static_symbol" }, tokenTypes = { "comment", "excluded_code", "identifier", "keyword", "keyword_control", "number", "operator", "operator_overloaded", "preprocessor_keyword", "string", "whitespace", "text", "static_symbol", "preprocessor_text", "punctuation", "string_verbatim", "string_escape_character", "class_name", "delegate_name", "enum_name", "interface_name", "module_name", "struct_name", "type_parameter_name", "field_name", "enum_member_name", "constant_name", "local_name", "parameter_name", "method_name", "extension_method_name", "property_name", "event_name", "namespace_name", "label_name", "xml_doc_comment_attribute_name", "xml_doc_comment_attribute_quotes", "xml_doc_comment_attribute_value", "xml_doc_comment_cdata_section", "xml_doc_comment_comment", "xml_doc_comment_delimiter", "xml_doc_comment_entity_reference", "xml_doc_comment_name", "xml_doc_comment_processing_instruction", "xml_doc_comment_text", "xml_literal_attribute_name", "xml_literal_attribute_quotes", "xml_literal_attribute_value", "xml_literal_cdata_section", "xml_literal_comment", "xml_literal_delimiter", "xml_literal_embedded_expression", "xml_literal_entity_reference", "xml_literal_name", "xml_literal_processing_instruction", "xml_literal_text", "regex_comment", "regex_character_class", "regex_anchor", "regex_quantifier", "regex_grouping", "regex_alternation", "regex_text", "regex_self_escaped_character", "regex_other_escape", }, }, range = true, } end end

local servers = {
  bashls = {},
  pyright = {},
  pylsp = {},
  clangd = {},
  tsserver = { on_attach = formattingOff() },
  cssls = {},
  emmet_ls = {},
  tailwindcss = { filetypes = { "typescriptreact", "javascriptreact" } },
  tsserver = { on_attach = formattingOff() },
  html = { on_attach = formattingOff() },
  jsonls = { on_attach = formattingOff() },
  intelephense = { 
    on_attach = formattingOff(), 
    init_options = { globalStoragePath = os.getenv('HOME') .. '/.local/share/intelephense' }
  },
  omnisharp = { 
    cmd = { "dotnet", "/Users/mireknguyen/.local/share/nvim/mason/packages/omnisharp/OmniSharp.dll" },
    on_attach = omnisharp_fix(),
  },
  tsserver = { on_attach = formattingOff() },
  smarty_ls = {},
}
return servers
