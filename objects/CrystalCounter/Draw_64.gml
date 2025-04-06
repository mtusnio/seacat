draw_self();

draw_set_font(HudFont);
draw_set_valign(fa_bottom);
draw_set_color(c_black)
draw_text(x + 10, y, global.collected_crystals);