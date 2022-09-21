object fmSaldoCaixa: TfmSaldoCaixa
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Saldo Caixa'
  ClientHeight = 444
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 630
    Height = 444
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 630
      Height = 81
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 32
        Top = 3
        Width = 76
        Height = 21
        Caption = 'Data Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 240
        Top = 3
        Width = 69
        Height = 21
        Caption = 'Data Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object btPesquisar: TButton
        Left = 528
        Top = 24
        Width = 73
        Height = 36
        Caption = 'Pesquisar'
        TabOrder = 0
        OnClick = btPesquisarClick
      end
      object dtInicio: TDateTimePicker
        Left = 32
        Top = 30
        Width = 186
        Height = 29
        Date = 44819.000000000000000000
        Time = 0.863447372685186600
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object dtFinal: TDateTimePicker
        Left = 240
        Top = 30
        Width = 186
        Height = 29
        Date = 44819.000000000000000000
        Time = 0.863447372685186600
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 337
      Width = 630
      Height = 64
      Align = alTop
      TabOrder = 1
      object SaldoFinal: TLabel
        Left = 16
        Top = 6
        Width = 92
        Height = 25
        Caption = 'Saldo Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbSaldoFinalValor: TLabel
        Left = 544
        Top = 23
        Width = 21
        Height = 25
        Caption = 'R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 273
      Width = 630
      Height = 64
      Align = alTop
      TabOrder = 2
      object lbSaldoParcial: TLabel
        Left = 16
        Top = 6
        Width = 115
        Height = 25
        Caption = 'Saldo Liquido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbSaldoParcialValor: TLabel
        Left = 544
        Top = 33
        Width = 21
        Height = 25
        Caption = 'R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 209
      Width = 630
      Height = 64
      Align = alTop
      TabOrder = 3
      object lbTotaldeSaidas: TLabel
        Left = 16
        Top = 6
        Width = 125
        Height = 25
        Caption = 'Total de Saidas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbTotalSaidaValor: TLabel
        Left = 544
        Top = 39
        Width = 21
        Height = 25
        Caption = 'R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object Panel6: TPanel
      Left = 0
      Top = 145
      Width = 630
      Height = 64
      Align = alTop
      TabOrder = 4
      object lbTotaldeEntradas: TLabel
        Left = 16
        Top = 6
        Width = 144
        Height = 25
        Caption = 'Total de Entradas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbTotalEntradaValor: TLabel
        Left = 544
        Top = 33
        Width = 21
        Height = 25
        Caption = 'R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
    object Panel7: TPanel
      Left = 0
      Top = 81
      Width = 630
      Height = 64
      Align = alTop
      TabOrder = 5
      object lbSaldoInicial: TLabel
        Left = 16
        Top = 6
        Width = 153
        Height = 25
        Caption = 'Saldo Inicial Caixa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbSaldoInicialValor: TLabel
        Left = 544
        Top = 24
        Width = 21
        Height = 25
        Caption = 'R$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
