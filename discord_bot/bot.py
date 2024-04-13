import vrising
import json
from dotenv import dotenv_values
from discord.ext import commands
import discord

config = dotenv_values(".env")

TOKEN=config['DISCORD_TOKEN']
PREFIX=config['PREFIX']

bot = discord.Client()

### PREFIX ###
bot = commands.Bot(command_prefix=PREFIX)

# succesfully message


@bot.event
async def on_ready():
    print(f'{bot.user} has connected to Discord!')

### CALL ###
#!info
@bot.command(name='info', help='bot info')
async def test(ctx):
    response = 'vservant'
    await ctx.send(response)

#!rise
@bot.command(name='rise')
async def test(ctx):
    await ctx.send("Your command has been received and it shall be done.")
    Message = vrising.start_server()
    print(Message)
    await ctx.send(Message)

#!fall
@bot.command(name='fall')
async def test(ctx):
    await ctx.send("Your command has been received and it shall be done.")
    Message = vrising.stop_server()
    print(Message)
    await ctx.send(Message)
    
bot.run(TOKEN)