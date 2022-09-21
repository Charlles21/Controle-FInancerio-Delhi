object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object SQL_CONEXAO: TFDConnection
    Params.Strings = (
      'Database=C:\DbSQLite\SistemaFinanceiro.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    FormatOptions.AssignedValues = [fvCheckPrecision]
    FormatOptions.CheckPrecision = True
    Connected = True
    Left = 320
    Top = 184
  end
end
