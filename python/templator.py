import vim
from operator import itemgetter, attrgetter, methodcaller
import re
import json

configFile = vim.eval('g:templator_config_dir')
with open(configFile) as configJson:
    config = json.load(configJson)
config = sorted(config, key=itemgetter('priority'), reverse=True)
lastTemplateSet = [];

for t in config:
    t['pattern'] = re.compile(t['pattern'])

def appendTemplate():
    global lastTemplateSet
    num = int(vim.eval('s:templator_selected_template')) - 1
    vim.command(lastTemplateSet[num]['command'])

def searchTemplate():
    global config

    filePath = vim.eval('expand("%")')
    fileName    = filePath.split('/').pop()
    fileFormat  = fileName.split('.', 1).pop()
    mathedTemplates = list(filter(lambda t: t['pattern'].search(filePath) != None, config))

    if len(mathedTemplates) == 0:
        return

    if int(vim.eval('g:templator_ingnore_priority')) == 0:
        maxPriority = mathedTemplates[0]['priority']
        mathedTemplates = list(filter(lambda t: t['priority'] == maxPriority, mathedTemplates))

    global lastTemplateSet
    lastTemplateSet= mathedTemplates

    if len(mathedTemplates) == 1:
        vim.command(mathedTemplates[0]['command'])
        return

    templateComments = []
    for template in mathedTemplates:
        templateComments.append(template['comment'])

    vim.command('call TemplatorShowSelectTemplatePopup(' + json.dumps(templateComments) + ')')


