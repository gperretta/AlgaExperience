//
//  TextureFunc.swift
//  AlgaExperience
//
//  Created by Alberto Di Ronza on 12/12/22.
//

import Foundation
import SpriteKit

// MARK: -SpriteKit extensions
extension SKSpriteNode {
    //function used to load texture array to animations
    func loadTexture (atlas: String , prefix : String, startsAt : Int, stopsAt : Int) -> [SKTexture]
    {
        var textureArray = [SKTexture]()
        let textureAtlas = SKTextureAtlas(named: atlas)
        for i in startsAt...stopsAt
        {
            let textureName = "\(prefix)\(i)" //così è facile switchare tra sprite in sequenza
            let temp = textureAtlas.textureNamed(textureName)
            textureArray.append(temp)
        }
        return textureArray
    }
//animations
        //con questo metodo gestiamo quante volte deve essere ripetuta l'animazione: il parametro count dice proprio questo if count==0 l'animazione viene rietuta per sempre, altrimenti viene ripetuta il numero di volte specificato
        func startAnimations(textures: [SKTexture], speed: Double, name: String, count: Int, resize: Bool, restore: Bool)
        {
            //run animations solo se non esiste già un'animations key (name->identificatore)
            if(action(forKey: name) == nil)
            {
                let animation = SKAction.animate(with: textures, timePerFrame: speed, resize: resize, restore: restore) //setta l'animazione frame-by-frame con le texture fornite, timePerFrame è il tempo di durata di ciascuna texture, resize e restore gesiscono come deve essere come l'azione deve maneggiare la taglia delle texture: resize=true la taglia dello sprite matcha la taglia dell'mmagine, restore=true la taglia originale della texture e ripristinata a fine animazione
                if count == 0{
                    let repeatAction = SKAction.repeatForever(animation)
                    run(repeatAction, withKey: name) //esegue l'azione
                }else if count == 1 {
                    run(animation, withKey: name)
                }else {
                    let reapeatAction = SKAction.repeat(animation, count: count)
                    run(reapeatAction, withKey: name)
                    //repeateForever e repeat determinano quante volte ripetere l'animazione(per sempre è un'opzione)
                }
            }
        }
    }

