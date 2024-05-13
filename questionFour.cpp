/*
	The code in the original question contained some memory leak issues for the dynamically allocated
	memory. 

	In my answer the memory for the player will be deallocated if the player fails or item creation fails
	as well as deallocate the object after the players data is saved if the player is offline. Item is also 
	deallocated.

	I used the delete to deallocate the memmory because it is typesafe and prevents memmory loss rather than
	using traditional methods like free and malloc
*/
void Game::addItemToPlayer(const std::string& recipient, unit16_t itemId)
{
	Player* player = g_game.getPLayerByName(recipient);

	//if the player is not found, attempt to load the player
	if (!player)
	{
		player = new Player(nullptr);
		if (!IOLoginData::loadPlayerByName(player, recipient))
		{
			delete player; //Deallocating the memory for player is the loading fails
			return;
		}
	}

	Item* item = item::CreateItem(itemId);

	if (!item)
	{
		delete player; //deallocating memeory for player if the item creation fails
		return;
	}

	g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

	//if the player is offline, save the player data
	if (player->isOffline())
	{
		IOLoginData::savePlayer(player);
	}

	//Deallocatiion for both Item and Player
	delete item;
	delete player;
}