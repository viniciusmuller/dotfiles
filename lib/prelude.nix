{
  mkLuaCode =
    (
      code:
      ''
        lua << EOF
          ${code}
        EOF
      ''
    );
}
