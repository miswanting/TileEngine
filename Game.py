# coding=utf-8

import os
import time
import threading

import pygame

game = {}
game['size'] = game['width'], game['height'] = 800, 600
game['fps'] = freq = 60


class TileEngine():
    def __init__(self):
        game['isRunning'] = True
        pygame.init()
        os.environ['SDL_VIDEO_CENTERED'] = '1'
        game['screen'] = pygame.display.set_mode(game['size'])

    def start(self):

        pygame.display.flip()
        time.sleep(1 / freq)

    def fps_star(self):
        while


if __name__ == '__main__':
    app = TileEngine()
    app.start()
