object frmClassificacaoPadrao: TfrmClassificacaoPadrao
  Left = 0
  Top = 0
  Caption = 'Classifica'#231#245'es'
  ClientHeight = 464
  ClientWidth = 647
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnAll: TPanel
    Left = 0
    Top = 0
    Width = 647
    Height = 464
    Align = alClient
    TabOrder = 0
    object pnBotton: TPanel
      Left = 1
      Top = 407
      Width = 645
      Height = 56
      Align = alBottom
      TabOrder = 0
      object btIncluir: TButton
        Left = 63
        Top = 11
        Width = 97
        Height = 35
        Caption = 'Incluir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btIncluirClick
      end
      object btAlterar: TButton
        Left = 182
        Top = 11
        Width = 97
        Height = 35
        Caption = 'Alterar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object btSair: TButton
        Left = 425
        Top = 11
        Width = 97
        Height = 35
        Caption = 'Sair'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btSairClick
      end
      object btExcluir: TButton
        Left = 306
        Top = 11
        Width = 97
        Height = 35
        Caption = 'Excluir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
    object pnTop: TPanel
      Left = 1
      Top = 1
      Width = 645
      Height = 56
      Align = alTop
      TabOrder = 1
      object dtPesquisar: TEdit
        Left = 8
        Top = 18
        Width = 225
        Height = 28
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object Button1: TButton
        Left = 256
        Top = 15
        Width = 97
        Height = 35
        Caption = 'Pesquisar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object Button2: TButton
        Left = 362
        Top = 18
        Width = 25
        Height = 25
        TabOrder = 2
      end
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 57
      Width = 645
      Height = 350
      Align = alClient
      DataSource = DataSource1
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'nome'
          Width = 188
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descricao'
          Width = 409
          Visible = True
        end>
    end
  end
  object DataSource1: TDataSource
    DataSet = dtClassificacao.cdsClassificacao
    Left = 592
    Top = 160
  end
end
