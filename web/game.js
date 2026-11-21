import * as THREE from 'three';
import { players } from './players.js';

const list = document.querySelector('#player-list');
for (const p of players) {
  const card = document.createElement('article');
  card.className = 'player-card';
  card.style.setProperty('--glow', p.glow);
  card.innerHTML = `
    <div class="player-top"><div class="ovr">${p.overall}<small>OVERALL</small></div><div class="rarity">${p.rarity}</div></div>
    <h3>${p.name}</h3><div class="role">${p.role} · PIEDE ${p.foot.toUpperCase()}</div>
    <div class="special">${p.ability} — ${p.technique}</div>`;
  list.appendChild(card);
}

const host = document.querySelector('#stadium');
const scene = new THREE.Scene();
scene.background = new THREE.Color('#07131d');
scene.fog = new THREE.Fog('#07131d', 18, 65);
const camera = new THREE.PerspectiveCamera(48, 1, .1, 100);
camera.position.set(0, 9, 19);
camera.lookAt(0, 0, 0);
const renderer = new THREE.WebGLRenderer({antialias:true,alpha:false});
renderer.setPixelRatio(Math.min(devicePixelRatio,1.7));
renderer.shadowMap.enabled = true;
renderer.shadowMap.type = THREE.PCFSoftShadowMap;
host.appendChild(renderer.domElement);
renderer.domElement.style.width='100%';
renderer.domElement.style.height='100%';
renderer.domElement.style.display='block';

scene.add(new THREE.HemisphereLight(0xb8e8ff,0x173126,2.1));
const key = new THREE.DirectionalLight(0xffffff,2.4);
key.position.set(-7,14,8);key.castShadow=true;scene.add(key);
const field = new THREE.Mesh(new THREE.PlaneGeometry(34,22),new THREE.MeshStandardMaterial({color:'#164b3b',roughness:.9}));
field.rotation.x=-Math.PI/2;field.receiveShadow=true;scene.add(field);
const lineMat = new THREE.MeshBasicMaterial({color:'#d5f4df'});
function line(x1,z1,x2,z2){const d=new THREE.Vector3(x2-x1,0,z2-z1);const m=new THREE.Mesh(new THREE.BoxGeometry(.055,.025,d.length()),lineMat);m.position.set((x1+x2)/2,.025,(z1+z2)/2);m.rotation.y=Math.atan2(d.x,d.z);scene.add(m)}
line(-15,-9,15,-9);line(15,-9,15,9);line(15,9,-15,9);line(-15,9,-15,-9);line(-15,0,15,0);
const circle = new THREE.Mesh(new THREE.RingGeometry(2.7,2.76,64),lineMat);circle.rotation.x=-Math.PI/2;circle.position.y=.04;scene.add(circle);
for(let i=0;i<8;i++){const pole=new THREE.Mesh(new THREE.CylinderGeometry(.09,.14,8,8),new THREE.MeshStandardMaterial({color:'#253d49'}));pole.position.set(i%2?15.8:-15.8,4,i<4?-10:10);scene.add(pole);const lamp=new THREE.PointLight(0xc8f8ed,30,18);lamp.position.set(pole.position.x,8,pole.position.z);scene.add(lamp)}
// Sagome 3D stilizzate: prototipo visivo, non ancora i modelli finali dei calciatori.
function player(x,z,color){const mat=new THREE.MeshStandardMaterial({color,roughness:.65});const body=new THREE.Mesh(new THREE.CapsuleGeometry(.42,.85,4,8),mat);body.position.set(x,1.05,z);body.castShadow=true;scene.add(body);const head=new THREE.Mesh(new THREE.SphereGeometry(.28,16,12),new THREE.MeshStandardMaterial({color:'#d9ad8c'}));head.position.set(x,1.9,z);scene.add(head);const legs=new THREE.Mesh(new THREE.BoxGeometry(.58,.75,.38),new THREE.MeshStandardMaterial({color:'#e8edf0'}));legs.position.set(x,.42,z);scene.add(legs)}
player(-4,1,'#55e6d0');player(3,-2,'#c9f36a');player(6,3,'#ff925c');
const ball=new THREE.Mesh(new THREE.SphereGeometry(.22,20,16),new THREE.MeshStandardMaterial({color:'#ffffff'}));ball.position.set(1,.23,1);scene.add(ball);
const clock=new THREE.Clock();
function resize(){const w=Math.max(host.clientWidth,1),h=Math.max(host.clientHeight,1);camera.aspect=w/h;camera.updateProjectionMatrix();renderer.setSize(w,h,false)}
new ResizeObserver(resize).observe(host);resize();
function animate(){requestAnimationFrame(animate);const t=clock.getElapsedTime();ball.position.y=.23+Math.abs(Math.sin(t*2))*.08;ball.rotation.z=t*.35;camera.position.x=Math.sin(t*.12)*.6;camera.lookAt(0,0,0);renderer.render(scene,camera)}
animate();
const loading=document.querySelector('#loading');
setTimeout(()=>{loading.style.opacity='0';setTimeout(()=>{loading.remove();document.querySelector('#app').classList.remove('hidden')},650)},1900);
