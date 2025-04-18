draw_self();

draw_set_font(HudFont);
draw_set_valign(fa_bottom);
draw_set_color(c_black)
draw_text(x + 10, y, string("{0}/{1}", global.collected_crystals, global.crystals_to_win));