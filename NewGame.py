# coding=utf-8

import math
import os
import threading
import time

import pygame

cfg = {}
cfg['size'] = cfg['w'], cfg['h'] = 800, 600  # 分辨率
cfg['l'] = 50
cfg['fps'] = 30  # FPS


class TileEngine():
    eg = {}  # Engine
    g = {}  # Game

    def __init__(self):
        self.eg['isRunning'] = True
        pygame.init()
        os.environ['SDL_VIDEO_CENTERED'] = '1'
        self.eg['screen'] = pygame.display.set_mode(cfg['size'], pygame.DOUBLEBUF)
        self.eg['screen'].set_alpha(None)
        self.eg['l_trunkStartX'], self.eg['l_trunkStartY'] = 0, 0  # Camera
        self.g['cx'], self.g['cy'] = 0, 0  # Camera
        self.eg['offTrunk'] = None
        self.eg['trunk'] = None

    def start(self):
        t_fps = threading.Thread(name='fps', target=self.fps_star)
        t_fps.start()
        self.eg['isTrunkIdle'] = True
        while self.eg['isRunning']:
            self.loop()
            pygame.display.flip()
            self.eg['tps'] += 1
            time.sleep(1 / self.eg['freq'])

    def fps_star(self):
        self.eg['freq'] = cfg['fps']
        self.eg['tps'] = 0
        self.eg['payload'] = 0
        while self.eg['isRunning']:
            time.sleep(1)
            self.eg['freq'] -= self.eg['tps'] - cfg['fps']
            self.eg['payload'] = 1 - 1 / self.eg['freq'] * cfg['fps']
            print(self.eg['freq'], self.eg['tps'], self.eg['payload'])
            self.eg['tps'] = 0

    def loop(self):
        # Game Stuff
        self.g['cx'] += 1
        self.g['cy'] += 1
        # Engine Stuff
        offTrunkStartX = math.floor((self.g['cx'] - cfg['w'] / 2) / cfg['l'])
        offTrunkStartY = math.floor((self.g['cy'] - cfg['w'] / 2) / cfg['l'])
        if not(self.eg['l_trunkStartX'] == offTrunkStartX and self.eg['l_trunkStartY'] == offTrunkStartY):
            if not self.eg['isTrunking']:
                # 刷新地图
                t_trunk = threading.Thread(name='trunk_star', target=self.trunk_star)
                t_trunk.start()
            if self.eg['isTrunked']:
                self.eg['trunkStartX'] = math.floor((self.g['cx'] - cfg['w'] / 2) / cfg['l'])
                self.eg['trunkStartY'] = math.floor((self.g['cy'] - cfg['w'] / 2) / cfg['l'])
                self.eg['trunk'] = self.eg['offTrunk']
                # tileCountX = math.floor(game['width'] / game['tileLength']) + 2
                # tileCountY = math.floor(game['height'] / game['tileLength']) + 2
                # t_startTileOfTrunkX = math.floor((game['cx'] - game['width'] / 2) / game['tileLength'])
                # t_startTileOfTrunkY = math.floor((game['cy'] - game['height'] / 2) / game['tileLength'])
                # global lastStartTileOfTrunkX, lastStartTileOfTrunkY
                # global startTileOfTrunkX, startTileOfTrunkY
                # if not(lastStartTileOfTrunkX == t_startTileOfTrunkX and lastStartTileOfTrunkY == t_startTileOfTrunkY):
                #     t_mapTrunk = threading.Thread(name='mapTrunk', target=self.mapTrunk_star)
                #     t_mapTrunk.start()
                # if flag['RefreshTrunkCompleted']:
                #     startTileOfTrunkX = math.floor((game['cx'] - game['width'] / 2) / game['tileLength'])
                #     startTileOfTrunkY = math.floor((game['cy'] - game['height'] / 2) / game['tileLength'])
                #     t['mapTrunk'] = t['offMapTrunk']
                #     flag['RefreshTrunkCompleted'] = False
                # if t['mapTrunk']:
                #     game['screen'].blit(t['mapTrunk'], (startTileOfTrunkX * game['tileLength'] - game['cx'] + game['width'] / 2,
                #                                         startTileOfTrunkY * game['tileLength'] - game['cy'] + game['height'] / 2))

    def trunk_star(self):
        self.eg['isTrunking'] = True
        self.eg['isTrunked'] = False

        self.eg['isTrunked'] = True
        self.eg['isTrunking'] = False
        # tileCountX = math.floor(game['width'] / game['tileLength']) + 2
        # tileCountY = math.floor(game['height'] / game['tileLength']) + 2
        # newMapTrunk = pygame.Surface((tileCountX * game['tileLength'], tileCountY * game['tileLength']))
        # t_startTileOfTrunkX = math.floor((game['cx'] - game['width'] / 2) / game['tileLength'])
        # t_startTileOfTrunkY = math.floor((game['cy'] - game['height'] / 2) / game['tileLength'])
        # for i in range(t_startTileOfTrunkX, t_startTileOfTrunkX + tileCountX):
        #     for j in range(t_startTileOfTrunkY, t_startTileOfTrunkY + tileCountY):
        #         newTile = pygame.Surface((game['tileLength'], game['tileLength']))
        #         if i == 0 and j == 0:
        #             newTile.fill((255, 255, 255))
        #         elif i == 0 or j == 0:
        #             newTile.fill((200, 200, 200))
        #         else:
        #             newTile.fill((255, 255, 255))
        #         pygame.draw.rect(newTile, (0, 0, 0), (0, 0, 50, 50), 1)
        #         font = pygame.font.Font(pygame.font.get_default_font(), 12)
        #         newTile.blit(font.render('{}x{}'.format(i, j), False, (0, 0, 0)), (0, 0))
        #         newTile = pygame.Surface.convert(newTile)
        #         newMapTrunk.blit(newTile, ((i - t_startTileOfTrunkX) * game['tileLength'], (j - t_startTileOfTrunkY) * game['tileLength']))
        # newMapTrunk = pygame.Surface.convert(newMapTrunk)
        # print(newMapTrunk.get_width())
        # t['offMapTrunk'] = newMapTrunk
        # flag['RefreshTrunkCompleted'] = True


if __name__ == '__main__':
    engine = TileEngine()
    engine.start()
