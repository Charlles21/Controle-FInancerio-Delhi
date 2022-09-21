program ControleFinanceiro;

uses
  Vcl.Forms,
  FormMenuPrincipal in 'FormMenuPrincipal.pas' {formControleFinanceiro},
  FormCadastroPadrao in 'FormCadastroPadrao.pas' {Caixa},
  Splash in 'Splash.pas' {formSplash},
  Conexao in 'Conexao.pas' {DataModule1: TDataModule},
  Usuarios in 'Usuarios.pas' {formUsuarios},
  dmUsuarios in 'Model\dmUsuarios.pas' {DataModule2: TDataModule},
  Utilitario in 'Util\Utilitario.pas',
  Login in 'Login.pas' {frmLogin},
  ModelUsuario in 'Model\Entidades\ModelUsuario.pas',
  udmCaixa in 'Model\udmCaixa.pas' {DataModule3: TDataModule},
  frmSaldoCaixa in 'frmSaldoCaixa.pas' {fmSaldoCaixa},
  CaixaResumo in 'Model\Entidades\CaixaResumo.pas',
  formClassificacao in 'formClassificacao.pas' {frmClassificacao},
  dmClassificacao in 'Model\dmClassificacao.pas' {dtClassificacao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TDataModule3, DataModule3);
  Application.CreateForm(TdtClassificacao, dtClassificacao);
  Application.CreateForm(TformControleFinanceiro, formControleFinanceiro);
  Application.CreateForm(TformUsuarios, formUsuarios);
  Application.CreateForm(TCaixa, Caixa);
  Application.CreateForm(TfmSaldoCaixa, fmSaldoCaixa);
  Application.CreateForm(TfrmClassificacao, frmClassificacao);
  Application.Run;
end.
