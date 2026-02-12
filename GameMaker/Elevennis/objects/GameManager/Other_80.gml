if (async_load[? "asset_id"] == snd_credits_intro && layer_get_visible(CreditsLayer))
{
    audio_play_sound(snd_credits, 1, true);
}