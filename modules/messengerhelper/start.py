import asyncio
from telethon import TelegramClient, events

# Replace with your own API ID and hash
api_id = 123456
api_hash = 'your_api_hash_here'

# Create a Telegram client instance
client = TelegramClient('session_name', api_id, api_hash)

@client.on(events.NewMessage)
async def handle_new_message(event):
    # Check if the incoming message is an audio file
    if event.message.media and isinstance(event.message.media, types.MessageMediaAudio):
        # Download the audio file
        await client.download_media(event.message.media, 'path/to/download/folder/')

# Start the Telegram client
client.start()