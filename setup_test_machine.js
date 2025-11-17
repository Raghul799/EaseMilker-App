/**
 * Setup script to create a test machine in Firestore
 * Run this with: node setup_test_machine.js
 */

const admin = require('firebase-admin');
const path = require('path');

// Initialize Firebase Admin SDK
const serviceAccount = require('./service-accounts/firebase-admin.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  projectId: 'ease-milker-app'
});

const db = admin.firestore();

async function setupTestMachine() {
  try {
    console.log('Setting up test machine...');
    
    // First, get the test user UID
    const testEmail = 'testuser@gmail.com';
    let userRecord;
    
    try {
      userRecord = await admin.auth().getUserByEmail(testEmail);
      console.log(`Found user: ${testEmail} with UID: ${userRecord.uid}`);
    } catch (error) {
      console.error(`User ${testEmail} not found. Please create this user in Firebase Console first.`);
      process.exit(1);
    }

    // Create the test machine document
    const machineId = 'EM1234';
    const machineData = {
      ownerId: userRecord.uid,
      machineId: machineId,
      name: 'Test Machine EM1234',
      model: 'EaseMilker Pro',
      status: 'idle',
      lastSeen: admin.firestore.FieldValue.serverTimestamp(),
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      
      // MQTT configuration (from .env)
      mqttBroker: 'r12107cf.ala.asia-southeast1.emqxsl.com',
      mqttPort: 8883,
      mqttUsername: 'easemilker',
      mqttPassword: 'EaseMilker@123',
      mqttUseTls: true,
      baseTopic: 'easemilker',
      
      // Machine settings
      settings: {
        autoMode: false,
        pulsationRate: 60,
        vacuumLevel: 50,
        temperature: 4
      }
    };

    await db.collection('machines').doc(machineId).set(machineData, { merge: true });
    console.log(`✅ Successfully created/updated machine: ${machineId}`);
    console.log(`   Owner: ${testEmail} (${userRecord.uid})`);
    console.log('\nYou can now login to the app with:');
    console.log('   Machine ID: EM1234');
    console.log('   Password: admin123');
    
  } catch (error) {
    console.error('Error setting up test machine:', error);
    process.exit(1);
  }
  
  process.exit(0);
}

setupTestMachine();
