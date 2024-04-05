import torch
import models.archs.CResMDNet_arch as CResMDNet_arch

def define_G(opt):
    opt_net = opt['network_G']
    which_model = opt_net['which_model_G']

    if which_model == 'CResMDNet':
        netG = CResMDNet_arch.CResMDNet(in_nc=opt_net['in_nc'], out_nc=opt_net['out_nc'],
                                    nf=opt_net['nf'], nb=opt_net['nb'], cond_dim=opt_net['cond_dim'])
    elif which_model == 'BaseNet':
        netG = CResMDNet_arch.BaseNet(in_nc=opt_net['in_nc'], out_nc=opt_net['out_nc'],
                                    nf=opt_net['nf'], nb=opt_net['nb'])
    elif which_model == 'CondNet':
        netG = CResMDNet_arch.CondNet(in_nc=opt_net['in_nc'], nf=opt_net['nf'])

    return netG