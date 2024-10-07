object DmDadosVisuais: TDmDadosVisuais
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 172
  Width = 346
  object dtsItensVenda: TDataSource
    DataSet = fdmemItensVenda
    Left = 55
    Top = 80
  end
  object fdmemItensVenda: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 56
    Top = 24
    object fdmemItensVendaprodutoid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'produtoid'
    end
    object fdmemItensVendanomeProduto: TStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'nomeProduto'
      Size = 100
    end
    object fdmemItensVendaquantidade: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'quantidade'
    end
    object fdmemItensVendavalorUnitario: TFloatField
      DisplayLabel = 'Pre'#231'o Unit'#225'rio'
      FieldName = 'valorUnitario'
      DisplayFormat = '#0.00'
    end
    object fdmemItensVendavalorTotalProduto: TFloatField
      DisplayLabel = 'Valor Total do Produto'
      FieldName = 'valorTotalProduto'
      DisplayFormat = '#0.00'
    end
  end
  object fdmemItensVendaCancel: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 224
    Top = 24
    object fdmemItensVendaCancelcancelprodutoid: TIntegerField
      FieldName = 'cancelprodutoid'
    end
  end
  object dsdtsItensVendaCancel: TDataSource
    DataSet = fdmemItensVendaCancel
    Left = 223
    Top = 80
  end
end
