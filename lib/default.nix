{ ... }:
{
  mkVimBool = val: if val then 1 else 0;

  writeIf = cond: msg: if cond then msg else "";

  withPlugins = cond: plugins: if cond then plugins else [ ];

  withAttrSet = cond: attrSet: if cond then attrSet else { };
}
