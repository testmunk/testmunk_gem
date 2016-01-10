class MainScreen < Testmunk::Android::Screen
  view :message, {marked: 'Hello World!'}
  button :click_me, {marked: 'Click me'}
  button :see_details, {marked: 'See details'}
  field :text_field, {marked: 'editText1'}


  def traits
    view({marked: 'Click me'})
  end

  def text(txt)
    view({text_contains:txt})
  end
end