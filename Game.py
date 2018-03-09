# coding=utf-8

import math
import os
import threading
import time

import pygame

game = {}
t = {}
game['size'] = game['width'], game['height'] = 800, 600  # 分辨率
game['fps'] = t['freq'] = t['tps'] = 30  # FPS
game['cx'], game['cy'] = 0, 0  # 镜头
t['tps'] = 0  # TickPerSecond（只读）
t['payload'] = 0  # 性能负载（只读）
t['mapTrunk'] = None
t['offMapTrunk'] = None
flag = {}
flag['RefreshTrunkCompleted'] = False

game['tileLength'] = 50
startTileOfTrunkX = startTileOfTrunkY = 0
lastStartTileOfTrunkX = lastStartTileOfTrunkY = 0
print(lastStartTileOfTrunkX, lastStartTileOfTrunkY)


class TileEngine():
    def __init__(self):
        game['isRunning'] = True
        pygame.init()
        os.environ['SDL_VIDEO_CENTERED'] = '1'
        print(pygame.display.Info())
        game['screen'] = pygame.display.set_mode(game['size'], pygame.DOUBLEBUF)
        game['screen'].set_alpha(None)

    def start(self):
        t_fps = threading.Thread(name='fps', target=self.fps_star)
        t_fps.start()
        while game['isRunning']:
            self.loop()
            pygame.display.flip()
            t['tps'] += 1
            time.sleep(1 / t['freq'])

    def fps_star(self):
        while game['isRunning']:
            time.sleep(1)
            t['freq'] -= t['tps'] - game['fps']
            t['payload'] = 1 - 1 / t['freq'] * game['fps']
            print(t['freq'], t['tps'], t['payload'])
            t['tps'] = 0

    def loop(self):
        game['cx'] += 1
        game['cy'] += 1
        tileCountX = math.floor(game['width'] / game['tileLength']) + 2
        tileCountY = math.floor(game['height'] / game['tileLength']) + 2
        t_startTileOfTrunkX = math.floor((game['cx'] - game['width'] / 2) / game['tileLength'])
        t_startTileOfTrunkY = math.floor((game['cy'] - game['height'] / 2) / game['tileLength'])
        global lastStartTileOfTrunkX, lastStartTileOfTrunkY
        global startTileOfTrunkX, startTileOfTrunkY
        if not(lastStartTileOfTrunkX == t_startTileOfTrunkX and lastStartTileOfTrunkY == t_startTileOfTrunkY):
            t_mapTrunk = threading.Thread(name='mapTrunk_star', target=self.mapTrunk_star)
            t_mapTrunk.start()
        if flag['RefreshTrunkCompleted']:
            startTileOfTrunkX = math.floor((game['cx'] - game['width'] / 2) / game['tileLength'])
            startTileOfTrunkY = math.floor((game['cy'] - game['height'] / 2) / game['tileLength'])
            t['mapTrunk'] = t['offMapTrunk']
            flag['RefreshTrunkCompleted'] = False
        if t['mapTrunk']:
            game['screen'].blit(t['mapTrunk'], (startTileOfTrunkX * game['tileLength'] - game['cx'] + game['width'] / 2,
                                                startTileOfTrunkY * game['tileLength'] - game['cy'] + game['height'] / 2))

    def mapTrunk_star(self):
        tileCountX = math.floor(game['width'] / game['tileLength']) + 2
        tileCountY = math.floor(game['height'] / game['tileLength']) + 2
        newMapTrunk = pygame.Surface((tileCountX * game['tileLength'], tileCountY * game['tileLength']))
        t_startTileOfTrunkX = math.floor((game['cx'] - game['width'] / 2) / game['tileLength'])
        t_startTileOfTrunkY = math.floor((game['cy'] - game['height'] / 2) / game['tileLength'])
        for i in range(t_startTileOfTrunkX, t_startTileOfTrunkX + tileCountX):
            for j in range(t_startTileOfTrunkY, t_startTileOfTrunkY + tileCountY):
                newTile = pygame.Surface((game['tileLength'], game['tileLength']))
                if i == 0 and j == 0:
                    newTile.fill((255, 255, 255))
                elif i == 0 or j == 0:
                    newTile.fill((200, 200, 200))
                else:
                    newTile.fill((255, 255, 255))
                pygame.draw.rect(newTile, (0, 0, 0), (0, 0, 50, 50), 1)
                font = pygame.font.Font(pygame.font.get_default_font(), 12)
                newTile.blit(font.render('{}x{}'.format(i, j), False, (0, 0, 0)), (0, 0))
                newTile = pygame.Surface.convert(newTile)
                newMapTrunk.blit(newTile, ((i - t_startTileOfTrunkX) * game['tileLength'], (j - t_startTileOfTrunkY) * game['tileLength']))
        newMapTrunk = pygame.Surface.convert(newMapTrunk)
        print(newMapTrunk.get_width())
        t['offMapTrunk'] = newMapTrunk
        flag['RefreshTrunkCompleted'] = True


if __name__ == '__main__':
    app = TileEngine()
    app.start()
