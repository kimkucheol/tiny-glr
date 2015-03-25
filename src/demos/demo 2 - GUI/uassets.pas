unit uAssets;

interface

uses
  glr_scene,
  glr_render,
  glr_render2d;

type

  { Assets }

  Assets = class
  public
    class var GuiAtlas: TglrTextureAtlas;
    class var GuiMaterial: TglrMaterial;
    class var GuiCamera: TglrCamera;
    class var GuiSpriteBatch: TglrSpriteBatch;

    class var FontMain: TglrFont;
    class var FontMainBatch: TglrFontBatch;

    // Base includes GUI, Fonts
    class procedure LoadBase();
    class procedure UnloadBase();
  end;

implementation

uses
  glr_filesystem, glr_core, glr_math;

const
  R_BASE = 'data/';
  R_GUI_ATLAS_IMG = R_BASE + 'gui.tga';
  R_GUI_ATLAS_TXT = R_BASE + 'gui.atlas';

{ Assets }

class procedure Assets.LoadBase();
begin
  GuiAtlas := TglrTextureAtlas.Create(
    FileSystem.ReadResource(R_GUI_ATLAS_IMG),
    FileSystem.ReadResource(R_GUI_ATLAS_TXT),
    extTga, aextCheetah);

  GuiMaterial := TglrMaterial.Create(Default.SpriteShader);
  GuiMaterial.AddTexture(GuiAtlas, 'uDiffuse');

  GuiCamera := TglrCamera.Create();
  GuiCamera.ProjectionMode := pmOrtho;
  GuiCamera.ProjectionModePivot := pTopLeft;
  GuiCamera.SetCamera(
    Vec3f(0, 0, 100),
    Vec3f(0, 0, 0),
    Vec3f(0, 1, 0));
  GuiCamera.Viewport(0, 0, Render.Width, Render.Height, 90, -1, 200);
end;

class procedure Assets.UnloadBase();
begin
  GuiAtlas.Free();
  GuiMaterial.Free();
end;

end.

