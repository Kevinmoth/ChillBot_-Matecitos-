import discord
from discord.ext import commands
import random
import os
import asyncio
import yt_dlp

intents = discord.Intents.default()
intents.presences = True
intents.messages = True
intents.guilds = True

current_song_index = 0
playlist = []

client = commands.Bot(command_prefix=".", intents=discord.Intents.all())

@client.event
async def on_ready():
    print(f"{client.user.name} está iniciando sesión")
    game = discord.Game("¡Guanabana!")
    await client.change_presence(activity=game)

@client.command()
async def play(ctx, *, query_or_url):
    global playlist
    voice_channel = ctx.author.voice.channel if ctx.author.voice else None

    if not voice_channel:
        await ctx.send(':mate: Debes estar en un canal de voz para usar este comando.')
        return

  
    if ctx.voice_client:
       
        await disconnect_vc(ctx, ctx.guild)

  
    voice_client = await voice_channel.connect()

    ydl_opts = {
        'format': 'bestaudio/best',
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '64',
        }],
        'outtmpl': 'song.mp3',
    }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        if "youtube.com" in query_or_url or "youtu.be" in query_or_url:
            info = ydl.extract_info(query_or_url, download=False)
            title = info['title']
            url = info['url']
        else:
            info = ydl.extract_info(f"ytsearch:{query_or_url}", download=False)
            title = info['entries'][0]['title'] if 'entries' in info else info['title']
            url = info['entries'][0]['url'] if 'entries' in info else info['url']

        playlist.append(url)
        await ctx.send(f':mate: Canción añadida a la lista de reproducción: {title}')

        try:
            emoji_id = 951309958727753788
            emoji = client.get_emoji(emoji_id)
            if emoji:
                await ctx.message.add_reaction(emoji)
        except discord.NotFound:
            print("Emoji no encontrado")
        except discord.Forbidden:
            print("No se puede reaccionar al mensaje debido a permisos insuficientes")

        if not ctx.voice_client.is_playing() and not ctx.voice_client.is_paused():
            await play_next(ctx, ctx.voice_client, title)


async def disconnect_vc(ctx, guild): 
    global current_song_index
    voice_client = discord.utils.get(client.voice_clients, guild=guild)
    if voice_client and voice_client.is_connected():
        await voice_client.disconnect()

        if current_song_index < len(playlist):
            next_song = playlist[current_song_index]
            ctx.voice_client.play(discord.FFmpegPCMAudio(next_song, executable="ffmpeg", options="-vn -b:a 192k -t 600"), after=lambda e: print('done', e))
        else:
            current_song_index = 0
    else:
        await ctx.send('No hay más canciones en la lista.')

@client.command()
async def play_next(ctx, voice_channel, title):
    global playlist
    if playlist:
        url = playlist.pop(0)
        voice_channel.play(discord.FFmpegPCMAudio(url, executable="ffmpeg", options="-vn -b:a 192k"), after=lambda e: asyncio.run(play_next(ctx, voice_channel, title)))
        await ctx.send(f':mate: Reproduciendo: {title}')
    else:
        await disconnect_vc(ctx.guild)

@client.command()
async def next(ctx):
    global current_song_index, playlist
    if current_song_index < len(playlist):
        await ctx.send(':mate: Pasando...')
        current_song_index += 1

        if ctx.voice_client.is_playing():
            ctx.voice_client.stop()

        if current_song_index < len(playlist):
            next_song = playlist[current_song_index]
            ctx.voice_client.play(discord.FFmpegPCMAudio(next_song, executable="ffmpeg", options="-vn -b:a 192k -t 600"), after=lambda e: print('done', e))
        else:
            current_song_index = 0
    else:
        await ctx.send('No hay más canciones en la lista!.')
        
client.run("Token")
